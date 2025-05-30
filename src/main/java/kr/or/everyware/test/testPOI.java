package kr.or.everyware.test;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/test")
public class testPOI {
    @GetMapping("go")
    public String goUp(){
        return "test";
    }

    @PostMapping("/poi")
    public String poiUp(@RequestPart(value="excelFile" , required = true )MultipartFile file, Model model) throws IOException {

        InputStream is = file.getInputStream();

        XSSFWorkbook workbook = new XSSFWorkbook(is);

        XSSFSheet sheet = workbook.getSheetAt(0);
        XSSFRow row = sheet.getRow(4);
        
        List<String> list = new ArrayList<String>();
		
        for(int i=0 ; i<13;i++) {
        row.getCell(i).setCellType(CellType.STRING);
        list.add( row.getCell(i).getStringCellValue());
        }

        model.addAttribute("num" ,list);
        
        return"test";
    }

}
