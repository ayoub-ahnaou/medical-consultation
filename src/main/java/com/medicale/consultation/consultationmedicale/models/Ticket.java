package com.medicale.consultation.consultationmedicale.models;

import com.medicale.consultation.consultationmedicale.models.person.Patient;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "tickets")
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private int order;

    @Column(nullable = false, name = "created_at")
    private LocalDate createdAt;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public Ticket(int id, int order, LocalDate createdAt) {
        this.id = id;
        this.order = order;
        this.createdAt = createdAt;
    }

    public Ticket() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }
}
