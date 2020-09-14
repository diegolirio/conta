package io.github.diegolirio.conta;

import lombok.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping
@SpringBootApplication
public class ContaApplication {

	public static void main(String[] args) {
		SpringApplication.run(ContaApplication.class, args);
	}

	@GetMapping("/{numero}")
	public ContaContabil getByNumero(@PathVariable("numero") Long numero) {
		return ContaContabil.builder().numero(numero).dateTimeRegistry(LocalDateTime.now()).build();
	}

	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	@Getter
	@Setter
	public static class ContaContabil {
		private Long numero;
		private LocalDateTime dateTimeRegistry;
	}
}
