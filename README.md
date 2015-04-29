# RingFileView-Objective-C
RingFileView written in  Objective-C, which can be used as a ImageViewer like a RingFile.

# Easy to use

    _ringFile = [[RingFileView alloc]initWithOrigin:CGPointMake(10, 10) PaperSize:CGSizeMake(200,300) PaperHoleInsetPersent:0.001 RingRadius:10];
    [self.view addSubview:_ringFileView];
    _ringFile.dataSource = ImageProvider Object;
    [_ringFile setEachFrontPageSmallerIndex:0];
    _ringFile.animationDuration =5;
    [self.view addSubview:_ringFile];    

add getNextPageImageAtPageIndex In ringFile.dataSource
    return UIImageObject;
    
# Set Page 5.
[_ringFile setEachFrontPageSmallerIndex:5];

# Turn to Right.
[_ringFile flipAtDirection:RightTOLeft]

# Turn To Left.
[_ringFile flipAtDirection:LeftToRight]

