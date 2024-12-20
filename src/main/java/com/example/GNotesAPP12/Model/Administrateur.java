package com.example.GNotesAPP12.Model;


import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Administrateur")
public class Administrateur extends Utilisateur{

    //Contructeur
    public Administrateur(Long code, String nom, String prenom, String nomUtilisateur, String motDePasse, Boolean isProfesseur, Boolean isAdmin) {
        super(code, nom, prenom, nomUtilisateur, motDePasse,isProfesseur, isAdmin);
    }
    public Administrateur() {
    }
}
