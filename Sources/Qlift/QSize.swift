import CQlift


public class QSize {
    var ptr: UnsafeMutableRawPointer!

    public var width: Int32 {
        get {
            return QSize_width(self.ptr)
        }
        set {
            QSize_setWidth(self.ptr, newValue)
        }
    }

    public var height: Int32 {
        get {
            return QSize_height(self.ptr)
        }
        set {
            QSize_setHeight(self.ptr, newValue)
        }
    }

    public init(width: Int32, height: Int32) {
        self.ptr = QSize_new(width, height)
    }

    init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }

    deinit {
        if self.ptr != nil {
            QSize_delete(self.ptr)
            self.ptr = nil
        }
    }
}
