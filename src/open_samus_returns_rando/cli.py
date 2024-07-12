import argparse
import json
import logging
import logging.config
import time
from pathlib import Path

from open_samus_returns_rando import samus_returns_patcher


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-path", required=True, type=Path,
                        help="Path to where the extracted Metroid: Samus Returns romfs to randomize can be found.")
    parser.add_argument("--input-exheader", required=False, type=Path,
                        help="Path to where the decrypted exheader can be found.")
    parser.add_argument("--output-path", required=True, type=Path,
                        help="Path to where the modified files will be written to.")
    parser.add_argument("--input-json", type=Path,
                        help="Path to the configuration json. If missing, it's read from standard input")
    return parser


def setup_logging() -> None:
    handlers = {
        'default': {
            'level': 'DEBUG',
            'formatter': 'default',
            'class': 'logging.StreamHandler',
            'stream': 'ext://sys.stdout',  # Default is stderr
        },
    }
    logging.config.dictConfig({
        'version': 1,
        'formatters': {
            'default': {
                'format': '[%(asctime)s] [%(levelname)s] [%(name)s] %(funcName)s: %(message)s',
            }
        },
        'handlers': handlers,
        'disable_existing_loggers': False,
        'loggers': {
            'default': {
                'level': 'DEBUG',
            },
        },
        'root': {
            'level': 'DEBUG',
            'handlers': list(handlers.keys()),
        },
    })
    logging.info("Hello world.")


def main() -> None:
    setup_logging()
    parser = create_parser()
    args = parser.parse_args()
    print(args)

    with args.input_json.open() as f:
        configuration = json.load(f)

    start = time.time()
    samus_returns_patcher.patch_extracted(
        args.input_path,
        args.input_exheader,
        args.output_path,
        configuration,
    )
    end = time.time()
    print(f"Patcher took {end - start:.03f} seconds")
