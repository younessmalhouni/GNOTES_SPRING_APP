package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Compte;
import com.example.GNotesAPP12.Model.Utilisateur;
import com.example.GNotesAPP12.Repo.CompteRepo;
import com.example.GNotesAPP12.Repo.UtilisateurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;


@Service
public class CompteService  {
    @Autowired
    private CompteRepo compteRepo;


    public Compte login(String nomUtilisateur, String motDePasse) {
        return compteRepo.findByNomUtilisateurAndMotDePasse(nomUtilisateur, motDePasse);
    }

    public void saveCompte(Compte compte) {
        compteRepo.save(compte);
    }


}

