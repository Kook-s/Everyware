package kr.or.everyware.everyware.cloud.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.services.s3.model.S3ObjectSummary;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.cloud.service.CloudService;
import kr.or.everyware.everyware.cloud.vo.Cloud;
import kr.or.everyware.everyware.cloud.vo.OrderProduct;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware/cloud")
@Slf4j
public class cloudController {

	@Inject
	private CloudService cloudService;

	@PreAuthorize("hasAnyAuthority('CLOUD')")
	@GetMapping("/cloud")
	public String cloudFileList(Model model, String path) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String myHomePath = "Everyware/" + employee.getCustId() + "/Employee/" + employee.getEmpId() + "/";
		String backFolder = "";
		String awsPath = "";
		String thisPath = "";
		float cldTotalSize = 0f;

		if (path == null || path.equals("")) {
			awsPath = myHomePath;
		} else {
			awsPath = path;
		}

		List<Cloud> cldList = new ArrayList<Cloud>();
		
		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "everyware";

		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, awsPath,
				new ByteArrayInputStream(new byte[0]), objectMetadata);

		try {
			s3.putObject(putObjectRequest);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		// list all in the bucket
		try {
			ListObjectsRequest listObjectsRequest = new ListObjectsRequest().withBucketName(bucketName)
					.withMaxKeys(300);

			ObjectListing objectListing = s3.listObjects(listObjectsRequest);

			System.out.println("Object List:");
			while (true) {
				for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
					log.info("    name=" + objectSummary.getKey() + ", size=" + objectSummary.getSize());
					
					
					if(objectSummary.getKey().contains("Everyware/" + employee.getCustId() + "/")) {
						cldTotalSize += objectSummary.getSize();
					}
					
					if (objectSummary.getKey().equals(awsPath) && objectSummary.getSize() == 0) {
						thisPath = extractPath(objectSummary.getKey());
					}

					if (objectSummary.getKey().contains(awsPath) && !objectSummary.getKey().equals(awsPath)
							&& countOccurrences(awsPath, objectSummary.getKey())) { // 경로를 포함하고 && 경로와 같지 않고 && '/' 조건이
																					// 같은때

						
						Cloud cloud = new Cloud();

						if (objectSummary.getSize() == 0) {
							backFolder = backFolder(extractPath(objectSummary.getKey()));

							cloud.setCldNm(folderName(objectSummary.getKey()));
							cloud.setCldPath(extractPath(objectSummary.getKey()));
							cloud.setCldTotalNm(extractFileName(objectSummary.getKey()));
							cloud.setCldTotalPath(objectSummary.getKey());
							cloud.setCldType("folder");
							cloud.setCldSize(objectSummary.getSize());
							cldList.add(cloud);

						} else {

							cloud.setCldNm(extractWord(objectSummary.getKey())); // 이름
							cloud.setCldPath(extractPath(objectSummary.getKey())); // 이름 제외 경로
							cloud.setCldTotalNm(extractFileName(objectSummary.getKey())); // 이름.형식
							cloud.setCldTotalPath(objectSummary.getKey()); // 전체 경로
							cloud.setCldType(extractFileExtension(objectSummary.getKey())); // 형식
							cloud.setCldSize(objectSummary.getSize()); // 사이즈
							cldList.add(cloud);
						}
						log.info("클라우드 담은거 ::: " + cloud);

					}

				}

				if (objectListing.isTruncated()) {
					objectListing = s3.listNextBatchOfObjects(objectListing);
				} else {
					break;
				}
			}
		} catch (AmazonS3Exception e) {
			System.err.println(e.getErrorMessage());
			System.exit(1);
		}
		model.addAttribute("employee", employee);
		model.addAttribute("myHomePath", myHomePath);
		model.addAttribute("backFolder", backFolder);
		model.addAttribute("cldList", cldList);
		model.addAttribute("thisPath", thisPath);
		model.addAttribute("menu", "emp");
		model.addAttribute("cloudActive", "active");
		
		cldTotalSize = cldTotalSize / 1073741824;
		String formattedNum = String.format("%.6f", cldTotalSize);

		model.addAttribute("cldTotalSize", formattedNum);
		OrderProduct orderProduct = cloudService.getOrCldSize(employee.getCustId());

		model.addAttribute("sCldTotalSize", orderProduct.getAddCldSz() * orderProduct.getOrdrPerson());

		return "everyware/cloud/cloud";
	}

	@PreAuthorize("hasAnyAuthority('CLOUD')")
	@GetMapping("/depCloud")
	public String DepCloudFileList(Model model, String path) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String myHomePath = "Everyware/" + employee.getCustId() + "/Department/" + employee.getDeptNm() + "/";
		String backFolder = "";
		String awsPath = "";
		String thisPath = "";
		float cldTotalSize = 0f;

		if (path == null || path.equals("")) {
			awsPath = myHomePath;
		} else {
			awsPath = path;
		}

		List<Cloud> cldList = new ArrayList<Cloud>();
		List<Cloud>folderList = new ArrayList<Cloud>();
		
		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "everyware";

		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, awsPath,
				new ByteArrayInputStream(new byte[0]), objectMetadata);

		try {
			s3.putObject(putObjectRequest);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		// list all in the bucket
		try {
			ListObjectsRequest listObjectsRequest = new ListObjectsRequest().withBucketName(bucketName)
					.withMaxKeys(300);

			ObjectListing objectListing = s3.listObjects(listObjectsRequest);

			System.out.println("Object List:");
			while (true) {
				for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
					log.info("    name=" + objectSummary.getKey() + ", size=" + objectSummary.getSize());
					
					if(objectSummary.getKey().contains("Everyware/" + employee.getCustId() + "/")) {
						cldTotalSize += objectSummary.getSize();
					}
					
					if (objectSummary.getKey().equals(awsPath) && objectSummary.getSize() == 0) {
						thisPath = extractPath(objectSummary.getKey());
					}

					if (objectSummary.getKey().contains(awsPath) && !objectSummary.getKey().equals(awsPath)
							&& countOccurrences(awsPath, objectSummary.getKey())) { // 경로를 포함하고 && 경로와 같지 않고 && '/' 조건이
																					// 같은때


						Cloud cloud = new Cloud();

						if (objectSummary.getSize() == 0) {
							backFolder = backFolder(extractPath(objectSummary.getKey()));

							cloud.setCldNm(folderName(objectSummary.getKey()));
							cloud.setCldPath(extractPath(objectSummary.getKey()));
							cloud.setCldTotalNm(extractFileName(objectSummary.getKey()));
							cloud.setCldTotalPath(objectSummary.getKey());
							cloud.setCldType("folder");
							cloud.setCldSize(objectSummary.getSize());
							cldList.add(cloud);

						} else {

							cloud.setCldNm(extractWord(objectSummary.getKey())); // 이름
							cloud.setCldPath(extractPath(objectSummary.getKey())); // 이름 제외 경로
							cloud.setCldTotalNm(extractFileName(objectSummary.getKey())); // 이름.형식
							cloud.setCldTotalPath(objectSummary.getKey()); // 전체 경로
							cloud.setCldType(extractFileExtension(objectSummary.getKey())); // 형식
							cloud.setCldSize(objectSummary.getSize()); // 사이즈
							cldList.add(cloud);
						}
						log.info("클라우드 담은거 ::: " + cloud);

					}

				}

				if (objectListing.isTruncated()) {
					objectListing = s3.listNextBatchOfObjects(objectListing);
				} else {
					break;
				}
			}
		} catch (AmazonS3Exception e) {
			System.err.println(e.getErrorMessage());
			System.exit(1);
		}
		
		model.addAttribute("employee", employee);
		model.addAttribute("myHomePath", myHomePath);
		model.addAttribute("backFolder", backFolder);
		model.addAttribute("cldList", cldList);
		model.addAttribute("thisPath", thisPath);
		model.addAttribute("menu", "dep");
		model.addAttribute("cloudActive", "active");

		cldTotalSize = cldTotalSize / 1073741824;
		String formattedNum = String.format("%.6f", cldTotalSize);

		model.addAttribute("cldTotalSize", formattedNum);
		OrderProduct orderProduct = cloudService.getOrCldSize(employee.getCustId());

		model.addAttribute("sCldTotalSize", orderProduct.getAddCldSz() * orderProduct.getOrdrPerson());

		return "everyware/cloud/cloud";
	}

	@GetMapping("/downloadCloud")
	public ResponseEntity<ByteArrayResource> downloadCloud(String cldTotalNm, String cldTotalPath) throws Exception {
		ServiceResult res = null;

		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();
		log.info("@@@ " + cldTotalNm);
		log.info("@@@ " + cldTotalPath);

		String bucketName = "everyware"; // 버킷 이름
		String objectName = cldTotalPath; // aws 안에서 다운받을 파일의 경체 경로
//		String downloadFilePath = "C:\\Users\\PC-20\\Desktop\\awsTest\\" + cldTotalNm; // 다운받을경로에 + test.txt
		String downloadFilePath = "C:\\Users\\"+System.getenv("USERNAME")+"\\Downloads\\"+ cldTotalNm; // 다운받을경로에 + test.txt
		log.info("다운로드 경로 확인  ::: "+downloadFilePath);
		// download object
		byte[] fileData=null;
		try {
			S3Object s3Object = s3.getObject(bucketName, objectName);
			S3ObjectInputStream s3ObjectInputStream = s3Object.getObjectContent();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	        byte[] buffer = new byte[4096];
	        int bytesRead;
			while ((bytesRead = s3ObjectInputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}
			fileData = outputStream.toByteArray();
			outputStream.close();
			s3ObjectInputStream.close();
			System.out.format("Object %s has been downloaded.\n", objectName);

			res = ServiceResult.OK;
			
			 // HTTP 응답 헤더 설정
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        headers.add("Content-Disposition", "attachment; fileName=\""+new String(cldTotalNm.getBytes("UTF-8"),"ISO-8859-1")+"\"");

	        // ByteArrayResource로 변환
	        ByteArrayResource resource = new ByteArrayResource(fileData);

	        // ResponseEntity에 ByteArrayResource와 헤더 및 상태 코드 설정
	        return new ResponseEntity<>(resource, headers, HttpStatus.CREATED);
		} catch (IOException e) {
	        // 파일 읽기 실패 등의 예외 처리
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    } catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(null, null, HttpStatus.OK);
	}

	@PostMapping("/deleteCloud")
	public ResponseEntity<ServiceResult> deleteCloud(String cldTotalNm, String cldTotalPath) {
		ServiceResult res = null;

		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "everyware";
		String objectName = cldTotalPath;

		// delete object
		try {
			s3.deleteObject(bucketName, objectName);
			System.out.format("Object %s has been deleted.\n", objectName);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

	@ResponseBody
	@PostMapping(value = "/uploadCloud", produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> uploadCloud(MultipartHttpServletRequest file, String thisPath) throws IOException {
		
		List<MultipartFile> fileList = file.getFiles("fileList");
		ServiceResult res = null;

		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "everyware";
		String folderName = thisPath; // 경로

		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName,
				new ByteArrayInputStream(new byte[0]), objectMetadata);

		try {
			s3.putObject(putObjectRequest);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		for (MultipartFile files : fileList) {
			log.info("::::: " + files.getOriginalFilename());
			log.info("::::: " + files.getInputStream());
			log.info("::::: " + files.getContentType());

			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentType(files.getContentType());
			metadata.setContentLength(files.getSize());

			try {

				s3.putObject(bucketName, folderName + files.getOriginalFilename(), files.getInputStream(), metadata);
				res = ServiceResult.OK;

			} catch (AmazonS3Exception e) {
				e.printStackTrace();
			} catch (SdkClientException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}

	@PostMapping("/createFoler")
	public String createFoler(Model model, String folderNm, String thisPath, String menu) {

		log.info("@@@@@@@  " + folderNm);
		log.info("@@@@@@@  " + thisPath);
		log.info("@@@@@@@  " + menu);

		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";

		// S3 client
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();

		String bucketName = "everyware";

		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(0L);
		objectMetadata.setContentType("application/x-directory");
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, thisPath + folderNm + "/",
				new ByteArrayInputStream(new byte[0]), objectMetadata);

		try {
			s3.putObject(putObjectRequest);
		} catch (AmazonS3Exception e) {
			e.printStackTrace();
		} catch (SdkClientException e) {
			e.printStackTrace();
		}

		if (menu.equals("emp")) {
			return "redirect:/everyware/cloud/cloud";
		}
		return "redirect:/everyware/cloud/depCloud";

	}
	 @ResponseBody
	 @GetMapping(value="/getCloutSize", produces = "application/json;charset=utf-8")
	public List<String> getCloutSize(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String endPoint = "https://s3.ap-northeast-2.amazonaws.com";
		String regionName = "ap-northeast-2";
		String accessKey = "";
		String secretKey = "";
		
		String bucketName = "everyware";
		String comCloutPath ="Everyware/"+employee.getCustId()+"/"; 
		float cldSize = 0f;
		
		final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
				.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
				.build();
		
		try {
			ListObjectsRequest listObjectsRequest = new ListObjectsRequest().withBucketName(bucketName).withMaxKeys(300);
			ObjectListing objectListing = s3.listObjects(listObjectsRequest);

			while (true) {
				for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
					log.info("    name=" + objectSummary.getKey() + ", size=" + objectSummary.getSize());
					if(objectSummary.getKey().contains(comCloutPath)) {
						cldSize +=objectSummary.getSize();
					}

				}

				if (objectListing.isTruncated()) {
					objectListing = s3.listNextBatchOfObjects(objectListing);
				} else {
					break;
				}
			}
		} catch (AmazonS3Exception e) {
			System.err.println(e.getErrorMessage());
			System.exit(1);
		}
		log.info("@     "+cldSize);
		cldSize = cldSize / 1073741824;
		log.info("@     "+cldSize);
		String formattedNum = String.format("%.6f", cldSize);
		log.info("@     "+formattedNum);
		OrderProduct orderProduct = cloudService.getOrCldSize(employee.getCustId());
//		
		List<String> list = new ArrayList<String>();
//		list.add("123");
		list.add(formattedNum);
		list.add((orderProduct.getAddCldSz() * orderProduct.getOrdrPerson())+"");


		
		return list;
	}
	

//-------------------- 글자 추출 메소드 ------------------------------------------------------
	public String extractWord(String input) {
		int lastSlashIndex = input.lastIndexOf('/');
		int dotIndex = input.lastIndexOf('.');
		if (lastSlashIndex != -1 && dotIndex != -1 && lastSlashIndex < dotIndex) {
			// If there is at least one slash and a dot after it, extract the text between
			// them.
			return input.substring(lastSlashIndex + 1, dotIndex).trim();
		} else {
			// If no valid 'test' part is found, return an empty string or handle it
			// accordingly.
			return "";
		}
	}

	public String extractPath(String input) {
		int lastSlashIndex = input.lastIndexOf('/');
		if (lastSlashIndex != -1) {
			// If there is at least one slash, extract the text before the last slash.
			return input.substring(0, lastSlashIndex + 1);
		} else {
			// If no valid path is found, return an empty string or handle it accordingly.
			return "";
		}
	}

	public String extractFileExtension(String input) {
		int lastDotIndex = input.lastIndexOf('.');
		if (lastDotIndex != -1 && lastDotIndex < input.length() - 1) {
			// If there is at least one dot and it's not the last character, extract the
			// file extension.
			return input.substring(lastDotIndex + 1);
		} else {
			// If no valid file extension is found, return an empty string or handle it
			// accordingly.
			return "";
		}
	}

	public String extractFileName(String input) {
		int lastSlashIndex = input.lastIndexOf('/');
		if (lastSlashIndex != -1 && lastSlashIndex < input.length() - 1) {
			// If there is at least one slash and it's not the last character,
			// extract the text after the last slash, which is the file name.
			return input.substring(lastSlashIndex + 1);
		} else {
			// If no valid file name is found, return an empty string or handle it
			// accordingly.
			return "";
		}
	}

	public boolean countOccurrences(String standard, String input) {

		if (standard.split("/", -1).length == input.split("/", -1).length - 1 && 1 != countJum(input) || // 폴더 비교
				standard.split("/", -1).length == input.split("/", -1).length // 파일 비교
		) {
			log.info(input + " 경로에 있는 파일");
			return true;
		}
		return false;
	}

	public int countJum(String str) {
		return str.split("\\Q" + '.' + "\\E", -1).length - 1;
	}

	public String folderName(String input) {
		int lastSlashIndex = input.lastIndexOf('/');

		String extracted = input.substring(0, lastSlashIndex);

		int secondLastSlashIndex = extracted.lastIndexOf('/');

		String result = extracted.substring(secondLastSlashIndex + 1);

		return result;
	}

	public String backFolder(String input) {

		int lastSlashIndex = input.lastIndexOf('/');

		String beforeLastSlash = input.substring(0, lastSlashIndex);

		lastSlashIndex = beforeLastSlash.lastIndexOf('/');
		String result = input.substring(0, lastSlashIndex + 1);

		return result;
	}

}
