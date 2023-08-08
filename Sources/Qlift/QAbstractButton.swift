import CQlift

open class QAbstractButton: QWidget {
    var clickedCallback: ((Bool) -> Void)?
    var toggledCallback: ((Bool) -> Void)?
    var pressedCallback: (() -> Void)?
    var releasedCallback: (() -> Void)?

    public var text: String{
        get {
            let s = QAbstractButton_text(ptr)
            return String(utf16CodeUnits: s.utf16, count: Int(s.size))
        }
        set { QAbstractButton_setText(self.ptr, newValue) }
    }

    override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    override func swiftCleanup() {
        super.swiftCleanup()
        clickedCallback = nil
        toggledCallback = nil
        pressedCallback = nil
        releasedCallback = nil
    }

    public func addIcon(_ icon: QIcon) {
        QAbstractButton_setIcon(ptr, icon.ptr)
    }

    public func setIconSize(_ size: QSize) {
        QAbstractButton_setIconSize(ptr, size.ptr)
    }

    public var checkable: Bool {
        get { QAbstractButton_getCheckable(ptr) }
        set { QAbstractButton_setCheckable(ptr, newValue) }
    }

    public var checked: Bool {
        get { QAbstractButton_getChecked(ptr) }
        set { QAbstractButton_setChecked(ptr, newValue) }
    }

    public var down: Bool {
        get { QAbstractButton_isDown(ptr) }
        set { QAbstractButton_setDown(ptr, newValue) }
    }

    open func connectClicked<T: AnyObject, R: Any>(receiver: QObject? = nil, type: Qt.ConnectionType = .AutoConnection, target: T, to slot: @escaping Slot<T, Bool, R>) {
        self.clickedCallback = { [weak target] in
            if let target = target { _ = slot(target)($0) }
        }
        QAbstractButton_clicked_connect(self.ptr, (receiver ?? self).ptr, Unmanaged.passUnretained(self).toOpaque(), type.rawValue) { raw, checked in
            let _self = Unmanaged<QAbstractButton>.fromOpaque(raw).takeUnretainedValue()
            _self.clickedCallback?(checked)
        }
    }

    public lazy var pressed = Pressed(ptr: self.ptr)
    public class Pressed {
        let ptr: UnsafeMutableRawPointer
        var callback: (() -> Void)?
        
        init(ptr: UnsafeMutableRawPointer) {
            self.ptr = ptr
        }
        deinit {
            if callback != nil {
                QAbstractButton_pressed_disconnect(self.ptr, nil)
            }
        }
        
        public func connect<T:QObject, R: Any>(receiver: QObject? = nil,
                                               type: Qt.ConnectionType = .AutoConnection,
                                               target: T,
                                               to slot: @escaping (T) -> () -> R) {
            self.callback = { [weak target] in
                if let target { _ = slot(target)() }
            }
            
            QAbstractButton_pressed_connect(
                    self.ptr,
                    receiver?.ptr ?? self.ptr,
                    Unmanaged.passUnretained(self).toOpaque(),
                    type.rawValue) {
                Unmanaged<Pressed>.fromOpaque($0).takeUnretainedValue().callback?()
            }
        }
        public func disconnect(receiver: QObject? = nil) {
            QAbstractButton_pressed_disconnect(self.ptr, receiver?.ptr ?? self.ptr)
            callback = nil
        }
    }

    public lazy var released = Released(ptr: self.ptr)
    public class Released {
        let ptr: UnsafeMutableRawPointer
        var callback: (() -> Void)?
        
        init(ptr: UnsafeMutableRawPointer) {
            self.ptr = ptr
        }
        deinit {
            if callback != nil {
                QAbstractButton_released_disconnect(self.ptr, nil)
            }
        }
        
        public func connect<T:QObject, R: Any>(receiver: QObject? = nil,
                                               type: Qt.ConnectionType = .AutoConnection,
                                               target: T,
                                               to slot: @escaping (T) -> () -> R) {
            self.callback = { [weak target] in
                if let target { _ = slot(target)() }
            }
            
            QAbstractButton_released_connect(
                    self.ptr,
                    receiver?.ptr ?? self.ptr,
                    Unmanaged.passUnretained(self).toOpaque(),
                    type.rawValue) {
                Unmanaged<Released>.fromOpaque($0).takeUnretainedValue().callback?()
            }
        }
        public func disconnect(receiver: QObject? = nil) {
            QAbstractButton_released_disconnect(self.ptr, receiver?.ptr ?? self.ptr)
            callback = nil
        }
    }

    public lazy var clicked = Clicked(ptr: self.ptr)
    public class Clicked {
        let ptr: UnsafeMutableRawPointer
        var callback: ((_ checked: Bool) -> Void)?
        
        init(ptr: UnsafeMutableRawPointer) {
            self.ptr = ptr
        }
        deinit {
            if callback != nil {
                QAbstractButton_clicked_disconnect(self.ptr, nil)
            }
        }
        
        public func connect<T:QObject, R: Any>(receiver: QObject? = nil,
                                               type: Qt.ConnectionType = .AutoConnection,
                                               target: T,
                                               to slot: @escaping (T) -> (_ checked: Bool) -> R) {
            self.callback = { [weak target] in
                if let target { _ = slot(target)($0) }
            }
            
            QAbstractButton_clicked_connect(
                    self.ptr,
                    receiver?.ptr ?? self.ptr,
                    Unmanaged.passUnretained(self).toOpaque(),
                    type.rawValue) {
                Unmanaged<Clicked>.fromOpaque($0).takeUnretainedValue().callback?($1)
            }
        }

        public func connect<T:QObject, R: Any>(receiver: QObject? = nil,
                                               type: Qt.ConnectionType = .AutoConnection,
                                               target: T,
                                               to slot: @escaping (T) -> () -> R) {
            self.callback = { [weak target] _ in
                if let target { _ = slot(target)() }
            }
            
            QAbstractButton_clicked_connect(
                    self.ptr,
                    receiver?.ptr ?? self.ptr,
                    Unmanaged.passUnretained(self).toOpaque(),
                    type.rawValue) {
                Unmanaged<Clicked>.fromOpaque($0).takeUnretainedValue().callback?($1)
            }
        }


        public func disconnect(receiver: QObject? = nil) {
            QAbstractButton_clicked_disconnect(self.ptr, receiver?.ptr ?? self.ptr)
            callback = nil
        }
    }

    public lazy var toggled = Toggled(ptr: self.ptr)
    public class Toggled {
        let ptr: UnsafeMutableRawPointer
        var callback: ((_ checked: Bool) -> Void)?
        
        init(ptr: UnsafeMutableRawPointer) {
            self.ptr = ptr
        }
        deinit {
            if callback != nil {
                QAbstractButton_toggled_disconnect(self.ptr, nil)
            }
        }
        
        public func connect<T:QObject, R: Any>(receiver: QObject? = nil,
                                               type: Qt.ConnectionType = .AutoConnection,
                                               target: T,
                                               to slot: @escaping (T) -> (_ checked: Bool) -> R) {
            self.callback = { [weak target] in
                if let target { _ = slot(target)($0) }
            }
            
            QAbstractButton_toggled_connect(
                    self.ptr,
                    receiver?.ptr ?? self.ptr,
                    Unmanaged.passUnretained(self).toOpaque(),
                    type.rawValue) {
                Unmanaged<Toggled>.fromOpaque($0).takeUnretainedValue().callback?($1)
            }
        }
        public func disconnect(receiver: QObject? = nil) {
            QAbstractButton_toggled_disconnect(self.ptr, receiver?.ptr ?? self.ptr)
            callback = nil
        }
    }

    
    
}
