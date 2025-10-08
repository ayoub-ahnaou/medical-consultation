package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient extends Person {
    @Column(nullable = false, name = "dossier_number", unique = true)
    private String dossierNumber;

    @Column(nullable = false, name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(nullable = false)
    private double height;

    @Column(nullable = false)
    private double weight;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Ticket> tickets = new ArrayList<>();

    public Patient(int id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt, Role role, String dossierNumber, LocalDate dateOfBirth, double height, double weight) {
        super(id, firstName, lastName, username, password, phone, gender, createdAt, role);
        this.dossierNumber = dossierNumber;
        this.dateOfBirth = dateOfBirth;
        this.height = height;
        this.weight = weight;
    }

    public Patient() {
        super();
    }

    public String getDossierNumber() {
        return dossierNumber;
    }

    public void setDossierNumber(String dossierNumber) {
        this.dossierNumber = dossierNumber;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }
}
