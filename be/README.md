## cara menjalankan :
 - npm i
 - npx sequelize-cli db:create
 - npx sequelize-cli db:migrate
 

## Endpoints :

List of available endpoints:
- `POST api/login`
- `POST api/register`
- `GET api/songs`
- `GET api/songs/:id`
- `DELETE api/songs/:id`
- `POST api/uploads`

&nbsp;

## 1. POST /api/login

Request:

- body:

```json
{
    "username": "string",
    "password": "string"
}
```

_Response (200 - OK)_

```json
{
    "access_token": "string"
}
```

_Response (400 - Bad Request)_

```json
{
    "message": "Validation Error"
}
```

&nbsp;

## 2. POST /api/register

- body:

```json
{
    "username": "string",
    "email": "string",
    "password": "string"
}
```

_Response (200 - OK)_

```json
{
    "id": "integer",
    "username": "string",
    "email": "string",
    "role": "string"
}
```

_Response (400 - Bad Request)_

```json
{
    "message": "Validation Error"
}
```

&nbsp;

## 3. GET /api/songs

_Response (200 - OK)_

```json
{
    "songs": [
        {
            "id": 3,
            "band": "Peterpan",
            "title": "Mimpi Yang Sempurna",
            "image": "uploads\\images\\1741648162016.jpg",
            "filePath": "uploads\\music\\1741648161853.mp3",
            "createdAt": "2025-03-10T23:09:22.026Z",
            "updatedAt": "2025-03-10T23:09:22.026Z"
        },
        {
            "id": 4,
            "band": "Boomerang Travi",
            "title": "Pelangi",
            "image": "uploads\\images\\1741709184324.jpg",
            "filePath": "uploads\\music\\1741709183788.mp3",
            "createdAt": "2025-03-11T16:06:24.339Z",
            "updatedAt": "2025-03-11T16:06:24.339Z"
        },
        {
            "id": 5,
            "band": "Mahen",
            "title": "Seamin tapi tak seiman",
            "image": "uploads\\images\\1741717125500.jpg",
            "filePath": "uploads\\music\\1741717125349.mp3",
            "createdAt": "2025-03-11T18:18:45.505Z",
            "updatedAt": "2025-03-11T18:18:45.505Z"
        }
    ]
}
```

&nbsp;

## 4. GET /api/songs/:id

Request:

- params:

```json
{
    "id": "integer (required)"
}
```

_Response (200 - OK)_

```json
{
    "song": {
        "id": 3,
        "band": "Peterpan",
        "title": "Mimpi Yang Sempurna",
        "image": "uploads\\images\\1741648162016.jpg",
        "filePath": "uploads\\music\\1741648161853.mp3",
        "createdAt": "2025-03-10T23:09:22.026Z",
        "updatedAt": "2025-03-10T23:09:22.026Z"
    }
}
```

_Response (404 - Not Found)_

```json
{
    "message": "Error not found"
}
```

&nbsp;


## 4. GET /api/uploads

Request:

- headers:

```json
{
    "access_token": "string"
}
```

- body:

```json
{
    "band": "string",
    "title": "string",
    "image": "file",
    "song" : "file"
}

