//
//  main.m
//  CustomCompilerProject
//
//  Created by Bill Gestrich on 12/23/23.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }

    int x = 0;
    if(x == 0); // <-- Note the accidental semicolon here, creating an empty body
    {
        printf("Incrementing x\n");
        x++;
    }

    return 0;
}
