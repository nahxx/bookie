package com.teamecho.bookie.common.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("common.service.commonService")
public class CommonService {
	
	@Autowired 
	ServletContext servletContext;
	
	/**
	 * 이미지파일 복사하는 메소드
	 * @param fileName
	 * @param newFolderUrl
	 * @throws IOException
	 */
	public void copyImage(String fileName, String newFolderUrl) throws IOException {
		// 임시 저장 경로
		String tempUrl = servletContext.getRealPath("/resources/temp/");
		// 최종 저장 경로
		String questionUrl = servletContext.getRealPath(newFolderUrl);
		File folder = new File(questionUrl);
		
		// 최종 저장 경로 없으면 생성
		if (!folder.exists()) folder.mkdirs();
		
		// 기존 파일, 새 파일
		File file = new File(tempUrl + fileName);
		File newFile = new File(questionUrl + fileName);
		
		// input, output 준비
		FileInputStream input = new FileInputStream(file);
		FileOutputStream output = new FileOutputStream(newFile);
		
		// 한번에 read하고 write할 사이즈 지정
		byte[] buf = new byte[1024];
		
		// buf사이즈만큼 read, write 작업
		int readData;
		while((readData = input.read(buf)) > 0) {
			output.write(buf, 0, readData);
		}
		
		// Stream close
		input.close();
		output.close();
	}
	
	/**
	 * 에디터의 html문자열에서 이미지저장명 받아오는 메소드
	 * @param htmlStr
	 * @return
	 */
	public List<String> getImageName(String htmlStr) {
		List<String> list = new ArrayList();
		StringTokenizer st = new StringTokenizer(htmlStr, "\"", true);
		while(st.hasMoreTokens()) {
			String str = st.nextToken();
			if(str.contains("http")) {
				String[] arr = str.split("/");
				list.add(arr[arr.length - 1]);
			}
		}
		return list;
	}
	
	/**
	 * 임시저장 폴더에서 이미지파일 찾아서 최종적으로 html에 포함된 이미지만 골라서 최종 폴더에 저장
	 * @param tempList (임시 저장된 imageName 리스트)
	 * @param FinalList (최종 등록된 imageName 리스트)
	 * @throws IOException
	 */
	public void saveFinalImages(List<String> tempList, List<String> FinalList) throws IOException {
		for(String imgName1 : tempList) {
			for(String imgName2 : FinalList) {
				if(imgName1.equals(imgName2)) {
					copyImage(imgName1, "/resources/question/question/");
				}
			}
		}
	}
	
	/**
	 * 임시 저장된 이미지 삭제하는 메소드
	 * @param imageNameList (삭제할 임시 저장된 imageName 리스트)
	 */
	public void deleteTempImages(List<String> imageNameList) {
		String tempUrl = servletContext.getRealPath("/resources/temp/");
		for(String imgName: imageNameList) {
			File file = new File(tempUrl + imgName);
			file.delete();
		}
	}
	
}
