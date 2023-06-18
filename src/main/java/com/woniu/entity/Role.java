package com.woniu.entity;

import lombok.Data;

import java.math.BigInteger;
import java.util.List;

/**
 * @description:
 * @author: my
 * @time: 2021/1/19 18:43
 */
@Data
public class Role {
    private Integer id;
    private String roleCode;
    private String roleName;
    private String createBy;
    private String creationDate;
    private BigInteger modifyBy;
    private String modifyDate;
}
