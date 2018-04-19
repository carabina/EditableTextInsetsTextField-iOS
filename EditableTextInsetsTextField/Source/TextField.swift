//
//  TextField.swift
//  EditableTextInsetsTextField
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct TapAdditionsKit.LocaleAdditions
import class UIKit.UITextField.UITextField
import class UIKit.UITextInput.UITextInputMode
import class UIKit.UITextInput.UITextRange

/// Base UITextField subclass.
open class TextField: UITextField {

    // MARK: - Public -
    // MARK: Properties

    /// Preferred language.
    public var preferredKeyboardLanguage: String = Locale.LocaleIdentifier.en

    /// Returns whole text range.
    public var textRange: UITextRange? {

        return self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
    }

    open override var textInputMode: UITextInputMode? {

        for inputMode in UITextInputMode.activeInputModes {

            guard let language = inputMode.primaryLanguage else { continue }

            if Locale.primaryLocaleIdentifier(from: language) == self.preferredKeyboardLanguage {

                return inputMode
            }
        }

        return super.textInputMode
    }

    // MARK: Methods

    /*!
     Resigns first responder. Overriden, because UITextField text jumps while resigning on custom fonts.
 
     - returns: true if resigned, false otherwise.
     */
    @discardableResult open override func resignFirstResponder() -> Bool {

        let resigned = super.resignFirstResponder()
        self.layout()

        return resigned
    }
}
