package com.example.GNotesAPP12.Model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
@DiscriminatorValue("Professeur")
public class Professeur extends Utilisateur {
    private String specialite;

    @OneToMany(mappedBy = "professeur", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Element> elements;

    // Constructors, Getters, and Setters
    public Professeur(Long code, String nom, String prenom, String nomUtilisateur, String motDePasse, String specialite, Boolean isProfesseur, Boolean isAdmin) {
        super(code, nom, prenom, nomUtilisateur, motDePasse, isProfesseur, isAdmin);
        this.specialite = specialite;
    }

    public Professeur() {
    }

    public String getSpecialite() {
        return this.specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public List<Element> getElements() {
        return elements;
    }

    public void setElements(List<Element> elements) {
        this.elements = elements;
    }
}
