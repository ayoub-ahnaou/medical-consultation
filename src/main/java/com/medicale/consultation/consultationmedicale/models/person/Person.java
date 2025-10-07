package com.medicale.consultation.consultationmedicale.models.person;

import com.google.protobuf.Enum;
import com.medicale.consultation.consultationmedicale.enums.Gender;
import jakarta.persistence.*;

import java.time.LocalDate;

@MappedSuperclass
public abstract class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "first_name", nullable = false, length = 50)
    protected String firstName;

    @Column(name = "last_name", nullable = false, length = 50)
    protected String lastName;

    @Column(unique = true, length = 20)
    protected String username;

    @Column(nullable = false)
    protected String password;

    @Column(length = 50)
    protected String phone;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    protected Gender gender;

    @Column(nullable = false, name = "created_at")
    protected LocalDate createdAt;

    public Person(int id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.createdAt = createdAt;
    }

    // required by JPA, if another constructor is defined
    public Person() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }
}
