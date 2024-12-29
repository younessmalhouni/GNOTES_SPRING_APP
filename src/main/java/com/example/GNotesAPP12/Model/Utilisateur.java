package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long code;

    private String nom;
    private String prenom;
    private String nomUtilisateur;
    private String motDePasse;
    private Boolean isProfesseur;
    private Boolean isAdmin;
    private String email;
    @Lob
    @Column(name = "image", columnDefinition = "LONGTEXT")
    private String image;

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

    public Utilisateur(Long code, String nom, String prenom, String nomUtilisateur, String motDePasse, Boolean isProfesseur, Boolean isAdmin, String email, String image) {
        this.code = code;
        this.nom = nom;
        this.prenom = prenom;
        this.nomUtilisateur = nomUtilisateur;
        this.motDePasse = motDePasse;
        this.isProfesseur = isProfesseur;
        this.isAdmin = isAdmin;
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

    public String getNomUtilisateur() {
        return this.nomUtilisateur;
    }

    public String getMotDePasse() {
        return this.motDePasse;
    }

    public Boolean getIsProfesseur() {
        return this.isProfesseur;
    }

    public Boolean getIsAdmin() {
        return this.isAdmin;
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

    public void setNomUtilisateur(String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public void setIsProfesseur(Boolean isProfesseur) {
        this.isProfesseur = isProfesseur;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    @Override
    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof Utilisateur)) return false;
        final Utilisateur other = (Utilisateur) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$code = this.getCode();
        final Object other$code = other.getCode();
        if (this$code == null ? other$code != null : !this$code.equals(other$code)) return false;
        final Object this$nom = this.getNom();
        final Object other$nom = other.getNom();
        if (this$nom == null ? other$nom != null : !this$nom.equals(other$nom)) return false;
        final Object this$prenom = this.getPrenom();
        final Object other$prenom = other.getPrenom();
        if (this$prenom == null ? other$prenom != null : !this$prenom.equals(other$prenom)) return false;
        final Object this$nomUtilisateur = this.getNomUtilisateur();
        final Object other$nomUtilisateur = other.getNomUtilisateur();
        if (this$nomUtilisateur == null ? other$nomUtilisateur != null : !this$nomUtilisateur.equals(other$nomUtilisateur)) return false;
        final Object this$motDePasse = this.getMotDePasse();
        final Object other$motDePasse = other.getMotDePasse();
        if (this$motDePasse == null ? other$motDePasse != null : !this$motDePasse.equals(other$motDePasse)) return false;
        final Object this$isProfesseur = this.getIsProfesseur();
        final Object other$isProfesseur = other.getIsProfesseur();
        if (this$isProfesseur == null ? other$isProfesseur != null : !this$isProfesseur.equals(other$isProfesseur)) return false;
        final Object this$isAdmin = this.getIsAdmin();
        final Object other$isAdmin = other.getIsAdmin();
        if (this$isAdmin == null ? other$isAdmin != null : !this$isAdmin.equals(other$isAdmin)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof Utilisateur;
    }

    @Override
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $code = this.getCode();
        result = result * PRIME + ($code == null ? 43 : $code.hashCode());
        final Object $nom = this.getNom();
        result = result * PRIME + ($nom == null ? 43 : $nom.hashCode());
        final Object $prenom = this.getPrenom();
        result = result * PRIME + ($prenom == null ? 43 : $prenom.hashCode());
        final Object $nomUtilisateur = this.getNomUtilisateur();
        result = result * PRIME + ($nomUtilisateur == null ? 43 : $nomUtilisateur.hashCode());
        final Object $motDePasse = this.getMotDePasse();
        result = result * PRIME + ($motDePasse == null ? 43 : $motDePasse.hashCode());
        final Object $isProfesseur = this.getIsProfesseur();
        result = result * PRIME + ($isProfesseur == null ? 43 : $isProfesseur.hashCode());
        final Object $isAdmin = this.getIsAdmin();
        result = result * PRIME + ($isAdmin == null ? 43 : $isAdmin.hashCode());
        return result;
    }


    public String toString() {
        return "Utilisateur(code=" + this.getCode() + ", nom=" + this.getNom() + ", prenom=" + this.getPrenom() + ", nomUtilisateur=" + this.getNomUtilisateur() + ", motDePasse=" + this.getMotDePasse() +" ,isProfesseur"+this.getIsProfesseur() +" ,isAdmin"+this.getIsAdmin() +")";
    }
}
