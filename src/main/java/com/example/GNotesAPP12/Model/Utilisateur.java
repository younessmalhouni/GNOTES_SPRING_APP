package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long code;

    private String nom;
    private String prenom;
    private String email;
    @Lob
    @Column(name = "image", columnDefinition = "LONGTEXT")
    private String image;

    @OneToMany(mappedBy = "utilisateur", cascade = CascadeType.ALL)
    private List<Compte> comptes;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Utilisateur(Long code, String nom, String prenom, String email, String image) {
        this.code = code;
        this.nom = nom;
        this.prenom = prenom;

        this.email = email;
        this.image = image;
    }

    public Utilisateur() {
    }


    public Long getCode() {
        return this.code;
    }

    public String getNom() {
        return this.nom;
    }

    public String getPrenom() {
        return this.prenom;
    }


    public void setCode(Long code) {
        this.code = code;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public List<Compte> getComptes() {
        return comptes;
    }





    public String toString() {
        return "Utilisateur(code=" + this.getCode() + ", nom=" + this.getNom() + ", prenom=" + this.getPrenom() +")";
    }
}
