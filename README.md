# Hasura SaaS starter
 
The purpose of this project is to provide a starter template for building a SaaS application with hasura.

## What you will find as part of the Hasura SaaS starter?

This project provides:

* docker-compose file that allows to start all the infrastructure you need.
* Hasura metadata and migrations for SaaS data model initialization


## How to start

You can clone or fork this project. If you decide to fork you will be able to keep up to date the infrastructure as well as the datamodel.

## Environment variables

```
POSTGRES_PASSWORD="postgrespassword"
HASURA_ADMIN_SECRET="myadminsecretkey"
```

# Components configuration

## Authentication and Authorization

Authentication and Authorization are the most important aspect of an SaaS. Hasura does not provide any out of the box authentication mechanism but it provides the fine grained authorization capabilities. Anyway hasura is able to read jwt tokens and it is able to inject claims has part of the hasura request.

This project relies on 3rd party authentication like Auth0 (for the moment it has been tested with Auth0 and maybe in the future will support additional providers mechanisms besides jwt), anyway it should be able to work with other openid connect providers such as Cognito or Firebase Auth.

### Auth0

In oreder to configure Auth0, you need to follow the steps provided in this page https://hasura.io/docs/latest/graphql/core/guides/integrations/auth0-jwt.html. With some small changes that will be listed below.

When your are at he step `Configure Auth0 Rules & Callback URLs` you will need to use the following snippet:

```javascript
function (user, context, callback) {
  const namespace = "https://hasura.io/jwt/claims";
  context.idToken[namespace] =
    {
      'x-hasura-default-role': 'user',
      // do some custom logic to decide allowed roles
      'x-hasura-allowed-roles': ['user'],
      'x-hasura-user-id': user.id_user
    };
  callback(null, user, context);
}
```


## Subscription and Payment


