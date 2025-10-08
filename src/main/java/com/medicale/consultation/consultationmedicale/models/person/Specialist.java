package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Speciality;
import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "specialists")
public class Specialist extends Person{
    @Column(nullable = false, unique = true, name = "numero_RPPS")
    private String numeroRPPS;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Speciality speciality;

    @Column(nullable = false, precision = 10, scale = 2)
    private double fee;

    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    private List<Request> requests = new ArrayList<>();

    public Specialist(int id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt, String numeroRPPS, Speciality speciality, double fee) {
        super(id, firstName, lastName, username, password, phone, gender, createdAt);
        this.numeroRPPS = numeroRPPS;
        this.speciality = speciality;
        this.fee = fee;
    }

    public Specialist() {}

    public String getNumeroRPPS() {
        return numeroRPPS;
    }

    public void setNumeroRPPS(String numeroRPPS) {
        this.numeroRPPS = numeroRPPS;
    }

    public Speciality getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Speciality speciality) {
        this.speciality = speciality;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }
}
