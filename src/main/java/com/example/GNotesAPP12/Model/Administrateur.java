package com.example.GNotesAPP12.Model;


import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Administrateur")
public class Administrateur extends Utilisateur{

    //Contructeur
    public Administrateur(Long code, String nom, String prenom, String email, String image) {
        super(code, nom, prenom, email, image);
    }
    public Administrateur() {
    }
}
