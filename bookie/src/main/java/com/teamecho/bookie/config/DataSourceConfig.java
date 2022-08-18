package com.teamecho.bookie.config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;


@Configuration
@ComponentScan(basePackages = "com.teamecho.bookie")
public class DataSourceConfig {
	
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		//mysql db
//		DataSource ds = new DataSource();
//		ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
//		ds.setUrl("jdbc:mysql://localhost:3306/bookie?serverTimezone=Asia/Seoul");
//		ds.setUsername("bookie");
//		ds.setPassword("bookie");
//		ds.setInitialSize(2);	// 커넥션 풀 초기화시 생성할 초기 커넥션 개수(기본값 10)
//		ds.setMaxActive(10);	// 풀에서 가져올 수 있는 최대 커넥션 개수(기본값 100)
//		ds.setMaxIdle(10);		// 풀에 유지할 수 있는 최대 커넥션 수(기본값은 MaxActive와 동일)
//		return ds;
		
		//maria db
		DataSource ds = new DataSource();
		ds.setDriverClassName("org.mariadb.jdbc.Driver");
		ds.setUrl("jdbc:mariadb://210.95.10.31:3307/bookie?serverTimezone=Asia/Seoul");
		ds.setUsername("bookie");
		ds.setPassword("Admin#123!@");
		ds.setInitialSize(2);	// 커넥션 풀 초기화시 생성할 초기 커넥션 개수(기본값 10)
		ds.setMaxActive(10);	// 풀에서 가져올 수 있는 최대 커넥션 개수(기본값 100)
		ds.setMaxIdle(10);		// 풀에 유지할 수 있는 최대 커넥션 수(기본값은 MaxActive와 동일)
		return ds;
	}

/*
	@Bean
    public CommonsMultipartResolver multipartResolver() {
       CommonsMultipartResolver resolver = new CommonsMultipartResolver();
       resolver.setDefaultEncoding("utf-8");
       return resolver;
    }
*/
	/*
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager txManager = new DataSourceTransactionManager();
		txManager.setDataSource(dataSource());
		return txManager;
	}
	*/
	
}
