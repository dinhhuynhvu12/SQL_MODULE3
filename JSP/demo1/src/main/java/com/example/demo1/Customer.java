package com.example.demo1;

import java.util.Date;

public class Customer {
    private String name;
    private Date birthDate;
    private String address;
    private String imageURL;

    public Customer(String name, Date birthDate, String address, String imageURL) {
        this.name = name;
        this.birthDate = birthDate;
        this.address = address;
        this.imageURL = imageURL;
    }

    public String getName() {
        return name;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public String getAddress() {
        return address;
    }

    public String getImageURL() {
        return imageURL;
    }
}
