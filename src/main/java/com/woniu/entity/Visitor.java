package com.woniu.entity;

public class Visitor {
    public String id;
    public String io;
    public String iotime;
    public String username;
    public String reason;

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
