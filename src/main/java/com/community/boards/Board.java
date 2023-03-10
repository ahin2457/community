package com.community.boards;

import java.util.Date;

/**
 * COMM_BOARDS 테이블을 표현하는 클래스다.
 * @author lee_e
 *
 */
public class Board {
	
	private int no;
	private String name;
	private String description;
	private int seq;
	private String readOption;
	private String writeOption;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private Date deletedDate;
	private int parentBoardNo;
	
	public Board() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getReadOption() {
		return readOption;
	}

	public void setReadOption(String readOption) {
		this.readOption = readOption;
	}

	public String getWriteOption() {
		return writeOption;
	}

	public void setWriteOption(String writeOption) {
		this.writeOption = writeOption;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public Date getDeletedDate() {
		return deletedDate;
	}

	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}

	public int getParentBoardNo() {
		return parentBoardNo;
	}

	public void setParentBoardNo(int parentBoardNo) {
		this.parentBoardNo = parentBoardNo;
	}
	
}
