package com.medicale.consultation.consultationmedicale.models.consultation;

import com.medicale.consultation.consultationmedicale.enums.RequestStatus;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "requests")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, name = "created_at")
    private LocalDate createdAt;

    @Column(nullable = false, name = "consultation_date")
    private LocalDate consultationDate;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private double cost;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "request_status")
    private RequestStatus requestStatus;

    @OneToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @ManyToOne
    @JoinColumn(name = "specialist_id", nullable = false)
    private Specialist specialist;

    public Request(int id, LocalDate createdAt, LocalDate consultationDate, String description, double cost, RequestStatus requestStatus) {
        this.id = id;
        this.createdAt = createdAt;
        this.consultationDate = consultationDate;
        this.description = description;
        this.cost = cost;
        this.requestStatus = requestStatus;
    }

    public Request() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDate getConsultationDate() {
        return consultationDate;
    }

    public void setConsultationDate(LocalDate consultationDate) {
        this.consultationDate = consultationDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public RequestStatus getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(RequestStatus requestStatus) {
        this.requestStatus = requestStatus;
    }
}
