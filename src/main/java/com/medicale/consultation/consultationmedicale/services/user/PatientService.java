package com.medicale.consultation.consultationmedicale.services.user;

import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.PatientRepository;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.util.List;

public class PatientService {
    private PatientRepository patientRepository;

    public PatientService(EntityManager em) {
        this.patientRepository = new PatientRepository(em);
    }

    public Patient findByFirstAndLastName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return null;
        }

        String[] parts = name.trim().split("\\s+", 2);
        String firstname = parts[0];
        String lastname = parts.length > 1 ? parts[1] : "";

        return patientRepository.findByFirstAndLastName(firstname, lastname);
    }

    public Patient findById(int id) {
        return patientRepository.findById(id);
    }

    public Patient create(String firstName, String lastName, String username, String password, String phone, Gender gender, Role role, String dossierNumber, LocalDate dateOfBirth, double height, double weight) {
        Patient patient = new Patient(firstName, lastName, username, password, phone, gender, role, dossierNumber, dateOfBirth, height, weight);
        patientRepository.save(patient);
        return patient;
    }

    public List<Patient> findAll() {
        return patientRepository.findAll();
    }
}
