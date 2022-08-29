package com.teamecho.bookie.test.repository;

import java.util.List;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.teamecho.bookie.question.domain.Question;
import com.teamecho.bookie.question.repository.QuestionRowMapper;
import com.teamecho.bookie.test.domain.LineSubjectPattern;

@Repository
public class CreateExamDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public CreateExamDao(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	/**
     * 작성자 : PDG
	 * 	 * 시험문제 만드는 쿼리
	 * -. 문제수량이 부족할수도 있기 때문에 문제 푼것도 시험지에 들어갈 수 있다.
	 * -. 대신 푼문제는 제일 밑으로 정렬을 해서 최대한 안푼문제 위주로 문제를 제출할 수 있도록 한다.
	 * -. 사용자키값과 LineSubjectPattern를 매개변수로 받아서 문제리스트를 던져준다.
	 * 
	 * @param uid
	 * @param lineSubjectPattern
	 * @return
	 */
	public List<Question> createExam(long uid, LineSubjectPattern lineSubjectPattern ) {
//		String sql = "SELECT q.*, a.identify FROM Question q "
//				+ "LEFT JOIN ( SELECT * FROM QuestionHistory qh WHERE qh.uid = ? ) a ON q.qid = a.qid "
//				+ "INNER JOIN QuestionPattern qp ON q.qId = qp.qId WHERE qp.spId = ? ORDER BY a.identify, RAND() LIMIT ?";
		String sql = "SELECT a.*"
				+ " FROM (SELECT  q.qid, q.qText, q.answer, q.qComment, q.qtId, q.mtId, q.cateId, q.regDate, a.identify  FROM Question q "
				+ " LEFT JOIN ( SELECT * FROM QuestionHistory qh WHERE qh.uid = ? ) a ON q.qid = a.qid GROUP BY q.qid ) a "
				+ " INNER JOIN QuestionPattern qp ON a.qId = qp.qId WHERE qp.spId = ? ORDER BY a.identify, RAND() LIMIT ?";
		return jdbcTemplate.query(sql, new QuestionRowMapper(), uid, lineSubjectPattern.getSubjectPattern().getSpId(), lineSubjectPattern.getQuestionCount());
	}
}
