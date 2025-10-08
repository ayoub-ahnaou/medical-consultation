package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "generalists")
public class Generalist extends Person {
    @Column(nullable = false, name = "numero_RRPS", unique = true)
    private String numeroRPPS;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false, length = 20)
    private String city;

    @Column(nullable = false)
    private double fee;

    @OneToMany(mappedBy = "generalist")
    private List<Consultation> consultations = new ArrayList<>(); // todo: verify this shit, ain't correct by the first time

    public Generalist(int id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt, Role role, String numeroRPPS, String address, String city, double fee) {
        super(id, firstName, lastName, username, password, phone, gender, createdAt, role);
        this.numeroRPPS = numeroRPPS;
        this.address = address;
        this.city = city;
        this.fee = fee;
    }

    public Generalist() {}

    public String getNumeroRPPS() {
        return numeroRPPS;
    }

    public void setNumeroRPPS(String numeroRPPS) {
        this.numeroRPPS = numeroRPPS;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }
}
