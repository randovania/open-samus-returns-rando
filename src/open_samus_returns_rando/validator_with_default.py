import typing

from jsonschema import Draft7Validator, validators


# FIXME: Types
def extend_with_default(validator_class: typing.Any) -> typing.Any:
    validate_properties: typing.Any = validator_class.VALIDATORS["properties"]

    def set_defaults(
            validator: typing.Any, properties: typing.Any, instance:typing.Any, schema:typing.Any
            ) -> typing.Any:
        for property, subschema in properties.items():
            if "default" in subschema:
                instance.setdefault(property, subschema["default"])

        yield from validate_properties(
                validator, properties, instance, schema,
        )

    return validators.extend(
        validator_class, {"properties": set_defaults},
    )


DefaultValidatingDraft7Validator = extend_with_default(Draft7Validator)
