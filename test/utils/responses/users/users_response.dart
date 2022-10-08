String get userForCompanyResponse => '''
{
  "user": [
      {
        "id": "bab4ab31-d22c-4180-9b53-e06390bd652b",
        "name": "Robert",
        "cpf": "1234567890",
        "birth_date": "2000-12-25",
        "id_company": "1566d92f-9119-44d5-830e-9c3f94eb657c",
        "types_user": {
          "id": "103925a9-9b8f-4a4f-a50a-1980d46d3d89",
          "name": "aluno"
        }
      }
    ]
}
''';

String get responseInserterUser => '''
{
  "insert_user": {
      "affected_rows": 1
    }
}''';

String get responseInserterUserError => '''
{
  "errors": [
    {
      "extensions": {
        "code": "constraint-violation",
        "path": "\$.selectionSet.insert_user.args.objects"
      },
      "message": "Uniqueness violation. duplicate key value violates unique constraint 'user_name_cpf_key'"
    }
  ]
}''';

String get responseUpdateUser => '''
{
    "update_user": {
      "affected_rows": 1
    }
}''';
