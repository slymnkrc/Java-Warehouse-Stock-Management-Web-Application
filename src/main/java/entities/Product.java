package entities;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pr_id;

    @Column(length = 100)
    private String pr_title;
    private double pr_buy_price;
    private double pr_sale_price;
    private long pr_code;
    private int pr_tax;
    private int pr_unit;
    @Column(length = 4)
    private double pr_quantity;
    @Column(length = 200)
    private String pr_detail;

    @OneToMany(cascade = CascadeType.DETACH, fetch = FetchType.EAGER)
    @JoinColumn(name = "pr_id")
    private List<BoxAction> boxActions;
}
