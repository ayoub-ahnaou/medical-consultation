package com.medicale.consultation.consultationmedicale.models.consultation;

import com.medicale.consultation.consultationmedicale.enums.RequestStatus;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "requests")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, name = "created_at")
    private LocalDateTime createdAt;

    @Column(nullable = false, name = "consultation_date")
    private LocalDateTime consultationDate;

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

    public Request(LocalDateTime consultationDate, String description, double cost, RequestStatus requestStatus) {
        this.createdAt = LocalDateTime.now();
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getConsultationDate() {
        return consultationDate;
    }

    public void setConsultationDate(LocalDateTime consultationDate) {
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

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public Specialist getSpecialist() {
        return specialist;
    }

    public void setSpecialist(Specialist specialist) {
        this.specialist = specialist;
    }

    public String getFormattedConsultationDate() {
        if (createdAt == null) return "";
        return consultationDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
