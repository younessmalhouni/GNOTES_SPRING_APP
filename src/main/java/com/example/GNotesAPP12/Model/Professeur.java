package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@DiscriminatorValue("Professeur")
public class Professeur extends Utilisateur {
    @Column(unique = true)
    private String IdentifiantProfesseur;

    private String specialite;


    @OneToMany(mappedBy = "professeur", cascade = CascadeType.ALL)
    private List<Element> elements;

    // Constructors, Getters, and Setters
    public Professeur(Long code, String nom, String prenom, String nomUtilisateur, String motDePasse, String specialite,String IdentifiantProfesseur , Boolean isProfesseur, Boolean isAdmin,String email, String image) {
        super(code, nom, prenom,email, image);
        this.specialite = specialite;
        this.IdentifiantProfesseur = IdentifiantProfesseur;
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

    public String getIdentifiantProfesseur() {
        return IdentifiantProfesseur;
    }

    public void setIdentifiantProfesseur(String IdentifiantProfesseur) {
        this.IdentifiantProfesseur = IdentifiantProfesseur;
    }

    @Override
    public List<Compte> getComptes() {
        return super.getComptes();
    }

}
