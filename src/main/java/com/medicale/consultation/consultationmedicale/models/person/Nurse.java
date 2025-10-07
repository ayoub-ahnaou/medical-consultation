package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "nurses")
public class Nurse extends Person {

    public Nurse(int id, String firstName, String lastName, String username, String password, String phone, Gender gender, LocalDate createdAt, String dossierNumber, LocalDate dateOfBirth, double height, double weight) {
        super(id, firstName, lastName, username, password, phone, gender, createdAt);
    }

    public Nurse() {}
}
