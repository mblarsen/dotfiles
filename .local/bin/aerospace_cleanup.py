import subprocess
from typing import Dict


def cleanup():
    res = subprocess.run(
        ["aerospace", "list-windows", "--all"], capture_output=True, text=True
    )

    def parse(w: str) -> Dict[str, str]:
        id, name, title = w.strip().split("|")
        return {"id": id.strip(), "name": name.strip(), "title": title.strip()}

    windows = [parse(w) for w in res.stdout.strip().split("\n")]
    print(f"{windows=}")
    windows = [w for w in windows if len(w["title"]) == 0]

    for w in windows:
        subprocess.run(["aerospace", "close", "--window-id", w["id"]])


if __name__ == "__main__":
    cleanup()
