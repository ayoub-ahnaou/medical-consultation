package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
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

    @Column(nullable = false)
    private double fee;

    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    private List<Request> requests = new ArrayList<>();

    public Specialist(String firstName, String lastName, String username, String password, String phone, Gender gender, Role role, String numeroRPPS, Speciality speciality, double fee) {
        super(firstName, lastName, username, password, phone, gender, role);
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
