package com.teamecho.bookie.user.web;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class EmailProvider {
	private String emailCode;
	private String emailHost;
}
