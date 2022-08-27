package com.teamecho.bookie.common.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ua_parser.Client;
import ua_parser.Parser;

public class ClientUtil {
	private static final Logger LOG = LoggerFactory.getLogger(ClientUtil.class.getName());
	
	/**
	 * 운영체제 반환하는 메소드
	 * @param request
	 * @return 운영체제 문자열
	 */
	public static String getOs(HttpServletRequest request) throws IOException {
		String headerStr = request.getHeader( "User-Agent" );
        String os = "";
        
        Parser parser = new Parser();
		Client client = parser.parse( headerStr );
		os = client.os.family;
        
        return os;
	}
}
