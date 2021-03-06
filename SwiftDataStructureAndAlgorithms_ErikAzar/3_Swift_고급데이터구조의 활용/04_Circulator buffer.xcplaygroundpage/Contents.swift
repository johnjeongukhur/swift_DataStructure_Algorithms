// Circulator buffer - ์ํ ๋ฒํผ

/*
 ๐๐๐บ๐ปโฆ๏ธ
 ๐ด๐ ๐ก๐ข๐ต๐ฃโช๏ธ๐ค
 โโ
 ๐ง 
*/

import Foundation

/*
 ์์ ๋ถ๋ถ์ ์ฐ๊ฒฐํด์ฃผ๋ - ํค๋ ์ธ๋ฑ์ค Head Index
                    - ํ์ผ ์ธ๋ฑ์ค Tale Index ๋ฑ
๐ ๊ณ ์  ํฌ๊ธฐ์ ๋ฐ์ดํฐ ๊ตฌ์กฐ
 
 ์ํ ๋ฒํผ - FIFO ๋ฐ์ดํฐ ๊ตฌ์กฐ๋ฅผ ๊ตฌํํ  ๋ ์ ์ฉํจ
        - Head index์ Tale index๊ฐ ๋ง๋ฌผ๋ ค ์์
        - ํฌ๊ธฐ๊ฐ ๊ณ ์ , ๊ณ ๋ก ๋ฒํผ์ ๋ฉ๋ชจ๋ฆฌ ํฌ๊ธฐ ์ญ์ ์์ ์  ์ํ
        

 Function
        - ๋ฒํผ์ ํฌ๊ธฐ๋ฅผ ์กฐ์ ํ  ์ ์๋ ๊ธฐ๋ฅ
        - ๊ธฐ์กด์ ๋ฐ์ดํฐ ์์๋ฅผ ์๋ก ์์ฑ๋ ๋ฒํผ๋ก ์ ๋ฌํ  ์ ์๋ ๊ธฐ๋ฅ
 ๋ฒํผ์ ํฌ๊ธฐ๋ฅผ ๋น๋ฒํ๊ฒ ์กฐ์ ํด์ผ ํ๋ ๊ฒฝ์ฐ,
 ๋ฐฐ์ด ๋์  *์ฐ๊ฒฐ ๋ชฉ๋ก
 */

/*
 ๐๋ฒํผ ๋ฉ์๋
 push() : ๋ฒํผ์ ๋์ ์์๋ฅผ ์ถ๊ฐ
 pop() : ๋ฒํผ์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ๋ฐํํ๊ณ  ๋ฒํผ์์ ์ญ์ 
 peek() : ๋ฒํผ์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ๋ฐํํ๋ ์ญ์ ํ์ง๋ ์์
 clear() : ๋ฒํผ๋ฅผ ์ฌ์ค์ ํด ๋น ์ํ๋ก ๋ง๋ฆ
 isEmpty() : ๋ฒํผ๊ฐ ๋น์ด์๋ ๊ฒฝ์ฐ true๋ฅผ ๋ฐํํ๊ณ , ๊ทธ๋ ์ง ์์ ๊ฒฝ์ฐ false๋ฅผ ๋ฐํ
 isFull() : ๋ฒํผ๊ฐ ๊ฐ๋ ์ฐจ์๋ ๊ฒฝ์ฐ true๋ฅผ ๋ฐํํ๊ณ , ์๋๋ฉด false
 count : ๋ฒํผ์ ํฌํจ๋ ์์์ ์๋ฅผ ๋ฐํ
 capacity : ๋ฒํผ์ ์ฉ๋์ ๋ฐํ ๋๋ ์ค์ ํ  ์ ์๋ read/write ํ๋กํผํฐ
 
 ๐๋์ฐ๋ฏธ ๋ฉ์๋
 insert(_:atIndex) : ๋ฒํผ์ ํน์  ์ธ๋ฑ์ค ์์น์ ์์๋ฅผ ์ฝ์ํ๋ ๋ฉ์๋
 removeAtIndex(_) : ๋ฒํผ์ ํน์  ์ธ๋ฑ์ค ์์น์ ์๋ ์์๋ฅผ ์ ๊ฑฐํ๋ ๋ฉ์๋
 
 */


// ๐ข ๊ตฌํ ๋ฐฉ๋ฒ

public struct CircularBuffer<T> {
    fileprivate var data: [T]
    fileprivate var head: Int = 0, tail: Int = 0
    
    private var interalCount: Int = 0
    private var overwriteOperation: CircularBufferOperation = CircularBufferOperation.Overwrite
    
    // ๋น CircularBuffer ๊ตฌ์กฐ๋ฅผ ์์ฑ
    public init() {
    data = [T]()
    data.reserveCapacity(Constants.defaultBufferCapacity)
    }
    
    // 'count' ํ๋กํผํฐ์ CircularBuffer๋ฅผ ์์ฑ
    // - ์ฃผ์: 'count'๋งํผ 2๋ฅผ ๊ฑฐ๋ญ์ ๊ณฑํ์ง ์์ ๊ฒฝ์ฐ,
    // ๊ทธ์ ๊ฐ์ฅ ๊ฐ๊น์ด ์๋งํผ 2๋ฅผ ๊ฑฐ๋ญ์ ๊ณฑํจ
    public init(_ count: Int, overwriteOperation: CircularBufferOperation = .Overwrite) {
        var capacity = count
        if (capacity < 1) {
            capacity = Constants.defaultBufferCapacity
        }
        
        // 'count'๋งํผ 2๋ฅผ ๊ฑฐ๋ญ์ ๊ณฑ์ผ๋ก ํจ
        if ((capacity & (~capacity +1)) != capacity) {
            var b = 1
            while (b < capacity) {
                b = b << 1
            }
            capacity = b
        }
        
        data = [T]()
        data.reserveCapacity(capacity)
        self.overwriteOperation = overwriteOperation
    }
    
    // ์ํ์ค์์ CircularBuffer๋ฅผ ์์ฑ
    public init<S: Sequence>(_ elements: S, size: Int)
    where S.Iterator.Element == T {
        self.init(size)
        elements.forEach({ push(element: $0) })
    }
    
    // ๋ฒํผ์์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ์ญ์ ํ ๋ค ๋ฐํ
    // - ๋ฐํ๊ฐ์ ํ์ :
    // - ๋ฒํผ๊ฐ ๋น์ด์์ง ์์ ๊ฒฝ์ฐ, ์ฒซ ๋ฒ์งธ ์์์ ํ์์ 'T'
    // - ๋ฒํผ๊ฐ ๋น์ด์๋ ๊ฒฝ์ฐ, 'nil'์ ๋ฐํ.
    public mutating func pop() -> T? {
        if (isEmpty()) {
            return nil
        }
        
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount -= 1
        return el
    }

}
