package entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ad_id;

    @Column(unique = true , length = 200)
    private String ad_email;

    @Column(length = 100)
    private String ad_username;
    private String ad_name;
    private String ad_surname;

    @Column(length = 32)
    private String ad_password;
}
