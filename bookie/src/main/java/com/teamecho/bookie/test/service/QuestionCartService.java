package com.teamecho.bookie.test.service;

import com.teamecho.bookie.test.domain.QuestionCart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("test.service.questionCartService")
public class QuestionCartService {

    @Autowired
    private QuestionCart questionCart;

}
