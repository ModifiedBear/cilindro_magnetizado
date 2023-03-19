# cilindro_magnetizado
Proyecto cilindro magnetizado

## Comenzando
### Prerequisitos

Se recomienda clonar por `ssh`. Para más información, ver [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

```sh
$ git clone git@github.com:ModifiedBear/cilindro-magnetizado.git
```

Hay que tener **Julia** instalado. Para más información, ver [instalación Julia](https://julialang.org/downloads/)

### Instalación

Abrir una Terminal en Mac/Linux o *PowerShell* en Windows.

Entrar al folder de instalación y correr Julia indicando el proyecto actual.
```sh
$ cd cilindro_magnetizado
$ julia --project=.
```
En el REPL de Julia, entrar al Pkg REPL con `]` y correr los siguientes comandos:
```julia
julia> ]
pkg> instantiate
pkg> precompile
```
Para salir del Pkg REPL, presionar `backspace`. Si todo se encuentra en orden, se debería poder correr cualquier función dentro del proyecto o módulo de la manera siguiente:
```julia
julia> using cilindro_magnetizado
julia> <función del proyecto>
```

¡Listo!
