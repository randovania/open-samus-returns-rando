import ips


class DSPatch(ips.Patch):
    def __init__(self):
        super().__init__(False)

    def add_record(self, offset, content, rle_size=-1):
        return super().add_record(offset, content, rle_size)
