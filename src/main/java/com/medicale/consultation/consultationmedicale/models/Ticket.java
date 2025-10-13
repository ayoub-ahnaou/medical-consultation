package com.medicale.consultation.consultationmedicale.models;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "tickets")
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, name = "created_at")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public Ticket(Patient patient, LocalDateTime createdAt) {
        this.patient = patient;
        this.createdAt = createdAt;
    }

    public Ticket() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getFormattedTime() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("HH:mm"));
    }
}
