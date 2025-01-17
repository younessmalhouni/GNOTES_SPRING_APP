package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Compte;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface CompteRepo extends JpaRepository<Compte, Long> {
    Compte findByNomUtilisateurAndMotDePasse(String nomUtilisateur, String motDePasse);

    @Query("SELECT c FROM Compte c " +
            "JOIN c.utilisateur u " +
            "WHERE u.email = :email"
    )
    Optional<Compte> findByEmail(String email);
    Optional<Compte> findByResetToken(String resetToken);
}