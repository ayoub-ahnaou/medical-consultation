package com.medicale.consultation.consultationmedicale.models.person;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "nurses")
public class Nurse extends Person {

    public Nurse(String firstName, String lastName, String username, String password, String phone, Gender gender, Role role) {
        super(firstName, lastName, username, password, phone, gender, role);
    }

    public Nurse() {}
}
