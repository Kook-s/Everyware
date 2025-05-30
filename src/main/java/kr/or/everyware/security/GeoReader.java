package kr.or.everyware.security;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import com.maxmind.geoip2.model.CityResponse;
import com.maxmind.geoip2.model.CountryResponse;

@Component
public class GeoReader {
  /*
	private static final String DATABASE_COUNTRY_PATH = "C:\\Users\\PC-26\\Desktop\\GeoLite2-ip로지역찾기\\GeoLite2-Country_20230726\\GeoLite2-Country.mmdb";
    private DatabaseReader reader;

    public GeoReader() throws IOException {
        File dbFile = new File(DATABASE_COUNTRY_PATH);
        reader = new DatabaseReader.Builder(dbFile).build();
    }

    public CityResponse city(InetAddress ipAddress) {
        CityResponse response = null;

        try {
            response = reader.city(ipAddress);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (GeoIp2Exception e) {
            e.printStackTrace();
        }

        return response;
    }
    
    public CountryResponse country(InetAddress ipAddress) {
        CountryResponse response = null;

        try {
            response = reader.country(ipAddress);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (GeoIp2Exception e) {
            e.printStackTrace();
        }

        return response;
    }
    */
}