package com.woniu.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * @description:
 * @author: my
 * @time: 2021/1/19 16:50
 */

//OSS   FastDFS   MinIO
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	private Integer id;
	private String userCode;
	private String userName;
	private String userPassword;
	private Integer gender;
	private String birthday;
	private String phone;

	private String roleName;
	private Integer roleId;
	private String address;
	private Integer createBy;
	private String creationDate;
	private Integer modifyBy;
	private LocalDateTime modifyDate;
}
