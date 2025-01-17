package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Compte {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idCompte;

    @Column
    private String nomUtilisateur;

    @Column
    private String motDePasse;

    @Column
    private Boolean isProfesseur;

    @Column
    private Boolean isAdmin;

    @Column
    private String resetToken;

    @Column
    private LocalDateTime resetTokenExpiry;

    public String getResetToken() {
        return resetToken;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public LocalDateTime getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    public void setResetTokenExpiry(LocalDateTime resetTokenExpiry) {
        this.resetTokenExpiry = resetTokenExpiry;
    }

    @ManyToOne
    @JoinColumn(name = "code")
    private Utilisateur utilisateur;

    // Getters and setters

    public Long getIdCompte() {
        return idCompte;
    }

    public void setIdCompte(Long idCompte) {
        this.idCompte = idCompte;
    }

    public String getNomUtilisateur() {
        return nomUtilisateur;
    }

    public void setNomUtilisateur(String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Boolean getIsProfesseur() {
        return isProfesseur;
    }

    public void setIsProfesseur(Boolean isProfesseur) {
        this.isProfesseur = isProfesseur;
    }

    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
}