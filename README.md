# Desafio DevOps BBCE

Para realização desse desafio foram criados:

Terraform:
 - 3 Repositorios no ECR para armazenamento das imagens docker das aplicações.
 - Cluster EKS usando o módulo da própria Hashcorp
 - Cluster Redis (elasticache), para conversar com as aplicações backend.

Kubernetes:
 - 3 Deployments e serviço (1 para cada aplicação).
 - 1 AWS Application Load balancer criado como Ingress para expor a aplicação de frontend para a internet.

CI/CD:
 - Criadas 3 pipelines para deploy automático das aplicações alterando a imagem nos deployments do Kubernetes. As pipelines são engatilhadas quando se faz um push para a branch especifica, por exemplo, ao fazer um push na branch frontend é feito o build da aplicação de frontend cria uma nova imagem com o hash da ultima tag do repositório no Github como tag da image, a imagem então é enviada para o ECR e o comando para alterar a imagem no deployment do Kubernetes é executado.


 Obs: 
 * Para o funcionamento do Application Load Balancer como Ingress do Kubenernetes é necessário a instalação do controller no cluster ( https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/ )
 * Foram alteradas no código fonte das aplicações os endereços para a chamada dos serviços do kubernetes para comunicação das aplicações, bem como o endereço do REDIS.
 * As pipelines que foram criadas podem ser encontradas na pasta .github/workflows