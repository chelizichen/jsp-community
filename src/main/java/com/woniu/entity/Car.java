package com.woniu.entity;

import lombok.Data;

@Data
public class Car {
    public String id;
    public String carid;
    public String username;
    public String paytype;
    public String io;
    public String iotime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCarid() {
        return carid;
    }

    public void setCarid(String carid) {
        this.carid = carid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPaytype() {
        return paytype;
    }

    public void setPaytype(String paytype) {
        this.paytype = paytype;
    }

    public String getIo() {
        return io;
    }

    public void setIo(String io) {
        this.io = io;
    }

    public String getIotime() {
        return iotime;
    }

    public void setIotime(String iotime) {
        this.iotime = iotime;
    }
}
