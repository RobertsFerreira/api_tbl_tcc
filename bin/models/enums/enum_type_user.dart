enum TypeUser {
  professor(descricao: 'professor'),
  aluno(descricao: 'aluno');

  final String descricao;
  const TypeUser({required this.descricao});
}
