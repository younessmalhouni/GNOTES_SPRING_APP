package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UtilisateurRepo extends JpaRepository<Utilisateur, String> {
    Utilisateur findByNomUtilisateurAndMotDePasse(String nomUtilisateur, String motDePasse);
    Utilisateur findByNomUtilisateur(String nomUtilisateur);
}
