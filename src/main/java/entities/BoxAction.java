package entities;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
public class BoxAction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int boxAction_id;

    @Column(nullable = false)
    private int amount;

    @Column(nullable = false)
    private String reciptNo;

    @Column(nullable = false)
    private Integer cu_id;

    @Column(nullable = false)
    private Integer pr_id;
    private Boolean orderStatus = false; //true: satıldı, false:sipariş aşamasında

    @OneToMany(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
    @JoinColumn(name = "ba_id", updatable = false)
    private List<Payment> payments;
}
