/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r5gc09oyr8nxfkl")

  collection.options = {
    "query": "SELECT\n    b.id as id,\n    b.name as name,\n    df.format AS date_format,\n    c.example AS currency_example,\n    o.email AS owner,\n    json_object('example', c.example) as foo,\n    b.created AS created,\n    b.updated AS updated\nFROM\n    budgets b\n    LEFT JOIN date_formats df ON b.date_format = df.id\n    LEFT JOIN currency_formats c ON b.currency_format = c.id\n    LEFT JOIN users o ON b.owner = o.id;\n"
  }

  // remove
  collection.schema.removeField("obgvoble")

  // remove
  collection.schema.removeField("cvkfmnlx")

  // remove
  collection.schema.removeField("nngmzwls")

  // remove
  collection.schema.removeField("u0xypzcz")

  // remove
  collection.schema.removeField("zc2fnk27")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "yvieoser",
    "name": "name",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "rc70wko3",
    "name": "date_format",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "x1vnucfq",
    "name": "currency_example",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "6gphduud",
    "name": "owner",
    "type": "email",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "exceptDomains": null,
      "onlyDomains": null
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "9z8sog3g",
    "name": "foo",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r5gc09oyr8nxfkl")

  collection.options = {
    "query": "SELECT\n    b.id as id,\n    b.name as name,\n    df.format AS date_format,\n    c.example AS currency_example,\n    o.email AS owner,\n    json_object('example', c.example) as foo,\n    -- JSON_ARRAY_LENGTH(c.example) as foo,\n    b.created AS created,\n    b.updated AS updated\nFROM\n    budgets b\n    LEFT JOIN date_formats df ON b.date_format = df.id\n    LEFT JOIN currency_formats c ON b.currency_format = c.id\n    LEFT JOIN users o ON b.owner = o.id;\n"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "obgvoble",
    "name": "name",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cvkfmnlx",
    "name": "date_format",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nngmzwls",
    "name": "currency_example",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "u0xypzcz",
    "name": "owner",
    "type": "email",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "exceptDomains": null,
      "onlyDomains": null
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "zc2fnk27",
    "name": "foo",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("yvieoser")

  // remove
  collection.schema.removeField("rc70wko3")

  // remove
  collection.schema.removeField("x1vnucfq")

  // remove
  collection.schema.removeField("6gphduud")

  // remove
  collection.schema.removeField("9z8sog3g")

  return dao.saveCollection(collection)
})
